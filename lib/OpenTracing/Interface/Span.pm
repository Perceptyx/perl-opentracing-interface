package OpenTracing::Interface::Span;

use strict;
use warnings;

=head1 NAME

OpenTracing::interface::Span - A role that defines the Span interface

=head1 SYNOPSIS

    pacakge OpenTracing::MyImplementation::Span;
    
    use Role::Tiny::With;
    
    with 'OpenTracing::Interface::Span'
        if $ENV{OPENTRACING_TYPECHECKS};
    
    ...
    
    sub get_context {
        ...
    }
    
    sub overwrite_operation_name {
        ...
    }
    
    ...
    
    1;

=head1 DESCRIPTION

This 'role' describes the interface for any OpenTracing Span implementation.

This description is using C<around> method modifiers that basically wraps them
around the real implementation. These method modifiers provide a 'readable' and
reusable interface, describing the inputs and outputs, using type constraints.

Since they do not do anything else, they can be switched-off during production.

=cut


use OpenTracing::ReadableInterface;
#
# auto imports a few tools for writing readable interfaces
# - arround
# - parameters, instance_method, class_method, and method_parameters
# - returns, and returns_self

use Types::Standard qw/Int Maybe Str Value/;
use Types::Common::Numeric qw/PositiveNum/;
use Types::Interface qw/ObjectDoesInterface/;


=head1 METHODS

=cut

=head2 get_context

Yields the SpanContext for this Span. Note that the return value of 
C<get_context()> is still valid after a call to L<finish()>, as is a call to
L<get_context()> after a call to L<finish()>.

    my $context = $span->get_context;
    

=head3 returns

An object that does the L<OpenTracing::Interface::SpanContext> role.

=cut

around get_context => instance_method ( ) {
    
    returns ( ObjectDoesInterface['OpenTracing::Interface::SpanContext'],
        
        $original->( $instance => ( ) )
        
    )
    
};



=head2 overwrite_operation_name( $operation_name )

Changes the operation name.

    $span->overwrite_operation_name( $operation_name );
    

=head3 required params

=over

=item operation_name

The name of the operation-name, must be a string.

=back

=head3 returns

The span itself, for chaining purposes.

=cut


around overwrite_operation_name => instance_method ( Str $operation_name ) {
    
    returns_self ( $instance,
         
        $original->( $instance => ( $operation_name ) )
        
    )
};



=head2 finish( undef | $epoch )

Sets the end timestamp and finalizes Span state.

    $span->finish;

or

    $span->finish( $epoch_timestamp );

With the exception of calls to C<get_context()> (which are always allowed),
C<finish()> must be the last call made to any span instance, and to do otherwise
leads to undefined behavior (but not returning an exception).

If the span is already finished, a warning should be logged.

=head3 optional params

=over

=item $epoch_timestamp

An explicit finish timestamp for the Span; if omitted, the current walltime is
used implicitly.

=back

=head3 retruns

The (finished) span itself, for chaining purposes.

=cut


around finish => instance_method ( Maybe[PositiveNum] $timestamp {
    
    returns_self ( $instance,
         
        $original->( $instance => ( $timestamp ) )
        
    )
};



=head2 set_tag( $tag_key, $string | $boolean | $number )

Adds a tag to the span

    $span->set_tag( $tag_key, $tag_value );
    

If there is a pre-existing tag set for tag_key, it is overwritten.

As an implementor, consider using "standard tags" listed in OpenTracing.io

If the span is already finished, a warning should be logged.

=head3 required params

=over

=item tag_key

A string.

OpenTracing does not enforce any limitations though.

=item tag_value

Must be either a string, a boolean value, or a numeric type.

=back

=head3 returns

The span itself, for chaining purposes.

=cut

around set_tag => instance_method ( Str $key, Value $value ) {
    
    returns_self ( $instance,
         
        $original->( $instance => ( $key, $value ) )
        
    )
};



=head2 log_data

Adds a log record to the span

    $span->log_data(
        $log_key1 => $log_value1,
        $log_key2 => $log_value2,
        ...
    );

=head3 required params

key/value pairs.

=head3 returns

The span itself, for chaining purposes.

=cut

around log_data => instance_method ( @log_data ) {
    
    Map[Str, Value]->( \@log_data );
    
    returns_self ( $instance,
         
        $original->( $instance => ( @log_data ) )
        
    )
};



=head2 set_baggage_item

Sets a key:value pair on this Span and its SpanContext that also propagates to
descendants of this Span.

    $span->set_bagagge_item(
        $baggage_key => $baggage_value
    );

Baggage items are key:value string pairs that apply to the given C<Span>, its
C<SpanContext>, and all Spans which directly or transitively reference the local
Span. That is, baggage items propagate in-band along with the trace itself.

Baggage items enable powerful functionality given a full-stack OpenTracing
integration (for example, arbitrary application data from a mobile app can make
it, transparently, all the way into the depths of a storage system), and with it
some powerful costs: use this feature with care.

Use this feature thoughtfully and with care. Every key and value is copied into
every local and remote child of the associated Span, and that can add up to a
lot of network and cpu overhead.

=head3 required parameters

=over

=item baggage_key, as String

=item baggage_value, as Value

=back

=head3 returns

The span itself, for chaining purposes.

=cut

around set_bagagge_item => instance_method ( Str $key, Value $value ) {
    
    returns_self ( $instance,
         
        $original->( $instance => ( $key, $value ) )
        
    )
};




=head2 get_baggage_item

Returns either the corresponding baggage value, or C<undef> when such a value
was missing.

    my $baggage_value = $span->get_baggage_item( $baggage_key );

=head3 required parameters

=over

=item baggage_key, as String

=back

=head3 returns

The value or C<undef> when such a value was missing.

=cut

around get_bagagge_item => instance_method ( Str $key ) {
    
    returns ( Maybe[Value],
         
        $original->( $instance => ( $key ) )
        
    )
}

1;