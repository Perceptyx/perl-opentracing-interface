package OpenTracing::Interface::Utils::RoleAround;

=head1 NAME

OpenTracing::Interface::Utils::RoleAround - Readable Intreface Definitions

=head1 SYNOPSIS

    package My::Class::interface;
    
    use OpenTracing::Interface::Utils::RoleAround;
    use Types::Standard qw/:all/;
    
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

But we have CPAN... L<RoleAround> will bring some of this, by providing a
few 'imports'.



=head1 EXPORTS

The following are exported into the callers namespace:

=cut



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

    returns ( $Type , $return_value )

Checks that the C<$return_value> is of type C<$Type> and returns that value, or
dies otherwise.

This is borrowed from C<assert_return>, found in L<Type::Tiny> and friends.



=head2 maybe_returns

    maybe_returns ( $Type , $return_value )

Just like L<returns>, however will accept C<undef> as well.


=head2 returns_self

    returns ( $self , $return_value )

Checks that the the C<$return_value>, is the same as C<$self>. That is just for
convenience when your method allows chaining and returns the same object.


=head2 maybe_returns_self

    returns ( $self , $return_value )

Same as L<returns_self> except that it allows for C<undef> to be returned. This
could be nice for interfaces that do not want to throw exceptions and use
C<undef> as a return value, to indicate that 'something' went wrong and therfore
do not return $self.

Be warned, allowing C<undef> to be returned, this will break the moment one will
try to chain methods. This causes "Can't call method $foo on undef" errors.
Which, of course, can be caught using C<try> blocks.

=cut



use strict;
use warnings;

use Function::Parameters;


our @ISA = qw/Exporter/;

our @EXPORT = qw(
    returns
    returns_maybe
    returns_self
    returns_maybe_self
    returns_object_does_interface
    returns_maybe_object_does_interface
);

use Import::Into;


use Type::Params qw/Invocant/;
use Types::Standard qw/ClassName Object Maybe/;
use Types::Interface qw/ObjectDoesInterface/;



sub returns {
    my $type_constraint = shift;
    
    $type_constraint->assert_return(@_)
}



sub returns_maybe {
    my $type_constraint = shift;
    
    ( Maybe[$type_constraint] )->assert_return(@_)
}



sub returns_self {
    my $self = shift;
    
    return $self if $self eq $_[0];
    
    die "Expected to return '\$self' [$self], got [$_[0]]\n";
}



sub returns_maybe_self {
    my $self = shift;
    
    return unless defined $_[0];
    
    return $self if $self eq $_[0];
    
    die "Expected to return '\$self' [$self], got [$_[0]]\n";
}



sub returns_object_does_interface {
    my $interface = shift;
    
    ( ObjectDoesInterface[$interface] )->assert_return(@_)
}



sub returns_maybe_object_does_interface {
    my $interface = shift;
    
    return unless defined $_[0];
    
    ( ObjectDoesInterface[$interface] )->assert_return(@_)
}



sub import {
    
    # TODO: We should only import what we really want to and select
    
    # see Function::Parameters on 'Wrapping Function::Parameters':
    #
    # Due to its nature as a lexical pragma, importing from Function::Parameters
    # always affects the scope that is currently being compiled. If you want to
    # write a wrapper module that enables Function::Parameters automatically,
    # just call Function::Parameters->import from your own import method (and
    # Function::Parameters->unimport from your unimport, as required).
    #
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
    
    Role::Tiny->import::into(scalar caller);
    #
    # provides `requires`, `with`
    # and the methodmodifiers `around`, `before`, and `after`
    
    __PACKAGE__->export_to_level( 1, @_ );
    #
    # whatever is in the list and can be exported, listed in `@EXPORT_OK`
    
}



1;

