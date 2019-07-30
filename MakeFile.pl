use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'          => 'OpenTracing::API',
    'VERSION_FROM'  => 'lib/OpenTracing/API.pod',
    'LICENSE'       => 'perl',
    'PREREQ_PM'     => {
        'Role::Tiny'    => 0,
    }
);