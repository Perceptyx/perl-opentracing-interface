use ExtUtils::MakeMaker::CPANfile;

WriteMakefile(
    'NAME'          => 'OpenTracing::Interface',
    'VERSION_FROM'  => 'lib/OpenTracing/Interface.pod',
    'LICENSE'       => 'perl',
    
    test => {
        'TESTS'         => 't/Utils/RoleAround/*.t t/*.t',
    },
    
);