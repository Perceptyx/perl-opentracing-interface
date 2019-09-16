use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'          => 'OpenTracing::Interface',
    'VERSION_FROM'  => 'lib/OpenTracing/Interface.pod',
    'LICENSE'       => 'perl',
    'PREREQ_PM'     => {
        'Role::Tiny'    => 0,
    }
);