use Test::Most;

BEGIN {
    $ENV{OPENTRACING_INTERFACE} = 1 unless exists $ENV{OPENTRACING_INTERFACE};
}
#
# This breaks if it would be set to 0 externally, so, don't do that!!!


our @test_params;




subtest "pass on arguments for 'activate_span'" => sub {
    
    undef @test_params;
    
    my $test_object = bless {}, 'MyTest::ScopeManager';
    
    my $mock_span = bless {}, 'MyTest::Span';
    
    lives_ok {
        $test_object->activate_span( $mock_span )
    } "Can call method 'activate_span'";
    
    lives_ok {
        $test_object->activate_span( $mock_span, finish_span_on_close => 1 )
    } "... can call 'activate_span' with 'finish_span_on_close'";
    
    cmp_deeply(
        \@test_params => [
            [
                obj_isa('MyTest::ScopeManager'),
                obj_isa('MyTest::Span'),
            ],
            [
                obj_isa('MyTest::ScopeManager'),
                obj_isa('MyTest::Span'),
                finish_span_on_close => 1,
            ],
        ],
        "... and the original subroutine gets the expected arguments"
    );
    
};



subtest "pass on arguments for 'get_active_scope'" => sub {
    
    undef @test_params;
    
    my $test_object = bless {}, 'MyTest::ScopeManager';
    
    lives_ok {
        $test_object->get_active_scope()
    } "Can call method 'get_active_scope'";
    
    cmp_deeply(
        \@test_params => [
            [ obj_isa('MyTest::ScopeManager') ],
        ],
        "... and the original subroutine gets the expected arguments"
    );
    
};



done_testing();



package MyTest::ScopeManager;

sub activate_span {
    push @main::test_params, [ @_ ];
    
    return bless {}, 'MyTest::Scope'
    
};

sub get_active_scope {
    push @main::test_params, [ @_ ];
    
    return bless {}, 'MyTest::Scope'
    
};

BEGIN {
    use Role::Tiny::With;
    with 'OpenTracing::Interface::ScopeManager'
}



package MyTest::Scope;

sub close;
sub get_span;

BEGIN {
    use Role::Tiny::With;
    with 'OpenTracing::Interface::Scope'
}



package MyTest::Span;

sub get_context;
sub overwrite_operation_name;
sub finish;
sub set_tag;
sub log_data;
sub set_baggage_item;
sub get_baggage_item;

BEGIN {
    use Role::Tiny::With;
    with 'OpenTracing::Interface::Span'
}



1;
