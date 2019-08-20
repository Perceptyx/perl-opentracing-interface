package OpenTracing::ReadableInterface;

=head1 NAME

OpenTracing::ReadableInterface - To make an Intreface Definition ... readable!

=head1 SYNOPSIS

    package My::Class::interface;
    
    use OpenTracing::ReadableInterface;
    
    around create_object => class_method ( Str $name, Int $age ) {
        returns( InstanceOf['My::Class'] ,
            $original->( $class => ( $name, $age )
        )
    };

    package My::Class;
    
    use Role::Tiny::With;
    
    with My::Class::interface unless $ENV{READABLE_INTERFACE}
    
    sub create_object {
        ...
    }

=head1 DESCRIPTION

Some languages have beautiful ways to describe a 'interface', explicitly showing
what methods are available, what arguments need to be passed in and what it will
return.

Perl does not.

But we have CPAN... L<ReadableInterface> will bring some of this, by providing a
few 'imports'.

=head1 IMPORTS

=head2 around

This is the C<around> method modifier, imported from L<Role::Tiny>. Basically,
the interface being described, is nothing else than a role.

=head2 parameters

    around $method => parameters ( $Type $foo, $Type $bar ) { ... }

After this keyword, it expects a list of parameters, that can have type
constraints, like those from L<Type::Tiny>. C<parameters> is a specific import
using L<Function::Parameters> and C<shift>s off C<$orig> and C<$self>.

So, inside the around method modifier CODEBLOCK, one can do:

    $orig->( $self => ( ... ) );

=head2 instance_method

    around $method => instance_methode ( $Type $foo, $Type $bar ) { ... }

Like L<parameters>, but instead of C<$self> generates a C<$instance> variable,
which must be of the type C<Object>, from L<Types::Standard>.

And inside the CODEBLOCK:

    $original->( $instance => ( ... ) );

=head2 class_method

    around $method => class_method ( $Type $foo, $Type $bar ) { ... }

Like L<parameters>, but instead of C<$self> generates a C<$class> variable,
which must be of the type C<ClassName>, from L<Types::Standard>.

And inside the CODEBLOCK:

    $original->( $class => ( ... ) );

=head2 method_parameters

    around $method => method_parameters ( $Type $foo, $Type $bar ) { ... }

Like L<parameters>, but instead of C<$self> generates a C<$invocant> variable,
which must be of the type C<Invocant>, from L<Type::Params>. Which is the union
of C<Object> type and <Class> type. Incase it is not sure which is being used.

And inside the CODEBLOCK:

    $original->( $invocant => ( ... ) );

=head2 returns

    returns ( $Type , $value )

Checks that the C<$value> is of type C<$Type> and returns that value, or dies
otherwise.

This is borrowed from C<assert_return>, found in L<Type::Tiny> and friends.

=cut

use strict;
use warnings;

use Function::Parameters;


our @ISA = qw(Exporter);
our @EXPORT = qw/&returns/;

use Import::Into;


use Types::Standard qw/ClassName Object/;
use Type::Params qw/Invocant/;



sub returns {
    my $type_constraint = shift;
    
    $type_constraint->assert_return(@_)
}



sub import {
    
    Function::Parameters->import(
        {
            parameters => {
                shift => ['$orig', '$self'],
            }
        },
        {
            instance_method => {
                shift => ['$original', ['$instance', Object]    ],
            }
        },
        {
            class_method => {
                shift => ['$original', ['$class',    ClassName] ],
            }
        },
        {
            method_parameters => {
                shift => ['$original', ['$invocant', Invocant]  ],
            }
        },
    );
    
    __PACKAGE__->export_to_level( 1, @_ );
    
    Role::Tiny->import::into(scalar caller);
    
}

1;

