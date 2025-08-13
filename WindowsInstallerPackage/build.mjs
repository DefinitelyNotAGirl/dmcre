import * as child_process from 'child_process';
import * as fs from 'fs';
import * as crypto from 'crypto'

// generate data.cpp

fs.writeFileSync('data.cpp', ``);
fs.appendFileSync('data.cpp',`
#include <stdint.h>\n
#include <string>\n
#include <vector>\n
#include "data.hpp"\n
`);

const files = [
    ...fs.readdirSync('../inc', { recursive: true }).map(file => ({dev: `../inc/${file}`, target: `%USERPROFILE%/.dmcre/global/${file}`})),
    {dev: '../bin/dmcre.exe', target: '%USERPROFILE%/.dmcre/bin/dmcre.exe'},
]
.filter(file => fs.statSync(file.dev).isFile())
.map(file => ({
    dev: file.dev.replace(/\\/g, '/'),
    target: file.target.replace(/\\/g, '/'),
    size: 0,
    hash: crypto.hash('sha256', file.dev),
}));

for (const file of files) {
    const data = fs.readFileSync(file.dev);
    file.size = data.length;
    fs.appendFileSync('data.cpp', `const uint8_t __Data_${file.hash}[] = {${Array.from(data).map((byte, index) => `${index % 32 == 0 ? '\n\t' : ''}0x${byte.toString(16).padStart(2, '0')},`).join('')}\n};`);
}

fs.appendFileSync('data.cpp',`
std::vector<std::pair<std::string, DataBuffer<const uint8_t*>>> EmbeddedFiles = {
${(() => {
    const EmbedFile = (file) => {
        console.log(`Embedding ${file.dev} as ${file.target}`);
        return `\tstd::pair<std::string,DataBuffer<const uint8_t*>>("${file.target.replace('%USERPROFILE%','\\xFF')}", DataBuffer<const uint8_t*>(__Data_${file.hash},${file.size})),`;
    }
    return files.map(EmbedFile).join('\n');
})()}
};`);

// Compile the C++ files into an executable
child_process.spawnSync('clang++', [
    '-g',
    '-std=c++20',
    'main.cpp',
    'Install.cpp',
    'data.cpp',
    '-o', 'Installer.exe',
    '-luser32',
    '-lgdi32',
    '-lAdvapi32',
], {
    stdio: 'inherit'
});
