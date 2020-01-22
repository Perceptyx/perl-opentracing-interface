use ExtUtils::MakeMaker::CPANfile;

WriteMakefile(
    'NAME'          => 'OpenTracing::Interface',
    'VERSION_FROM'  => 'lib/OpenTracing/Interface.pod',
    'ABSTRACT_FROM' => 'lib/OpenTracing/Interface.pod',
    'LICENSE'       => 'artistic2',
    
    test => {
        'TESTS'         => 't/*.t',
    },
    
);