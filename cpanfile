requires        'Function::Parameters';
requires        'Import::Into';
requires        'Role::Tiny';
requires        'Type::Params';
requires        'Type::Tiny';
requires        'Types::Common::Numeric';
requires        'Types::Interface';
requires        'Types::Standard';


on 'develop' => sub {
    requires    "ExtUtils::MakeMaker::CPANfile";
};


on 'test' => sub {
    requires    "Test::Most";
};
