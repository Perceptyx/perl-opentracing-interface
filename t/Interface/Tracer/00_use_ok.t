use Test::Most;

BEGIN {
    $ENV{EXTENDED_TESTING} = 1 unless exists $ENV{EXTENDED_TESTING};

    use_ok('OpenTracing::Interface::Tracer');
    
};

done_testing;
