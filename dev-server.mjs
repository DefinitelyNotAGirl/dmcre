import * as http from 'http'
import * as child_process from 'child_process'
import * as fs from 'fs'

const server = http.createServer({
},(request,response) => {
	console.log(`${request.method} ${request.url}`);

	if(request.url.startsWith('/docs') || request.url == '/') {
		child_process.execSync('node --disable-warning=ExperimentalWarning docs.build.mts',{
			stdio: 'inherit'
		})

		response.writeHead(200,'OK');
		response.write(fs.readFileSync('documentation_out.html'));
		response.end();
		return;
	}

	response.writeHead(404,'NOT FOUND');
	response.end();
});

server.listen(10005,'127.0.0.1');
