requires        'Role::MethodReturns';
requires        'Type::Library';
requires        'Type::Utils';
requires        'Types::Common::Numeric';
requires        'Types::Interface';
requires        'Types::Standard';


on 'develop' => sub {
    requires    "ExtUtils::MakeMaker::CPANfile";
};


on 'test' => sub {
    requires    "Test::Most";
};
