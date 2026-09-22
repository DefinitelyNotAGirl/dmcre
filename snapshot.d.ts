declare var snapshot_version: (version: string) => void;
declare var snapshot_Language: (language: string) => void;
declare var snapshot_returnType: (type: any) => void;
declare var snapshot_QualifiedName: (name: string) => void;
declare var snapshot_UnqualifiedName: (name: string) => void;
declare var snapshot_SourceFile: (file: string) => void;
declare var snapshot_SourceLine: (line: number) => void;
declare var snapshot_TagTypeKind: (type: string) => void;
declare var snapshot_isAbstract: (isAbstract: boolean) => void;
declare var snapshot_parameter: (type: any,name: string) => void;
declare var snapshot_templateParameter: (type: any,name: string) => void;
declare var snapshot_dataType: (type: any) => void;
declare var snapshot_EnumConstant_value: (value: number) => void;
declare var snapshot_attribute: (str: string) => void;

declare function ResetSnapshotEval(): void;

declare function EvaluateSnapshots(key: string): void;

