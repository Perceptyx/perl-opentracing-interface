package OpenTracing::Role::Span;

use Role::Tiny;

=head1 NAME

OpenTracing::Role::Span - A role that defines the Span interface

=head1 METHODS

=cut

=head2 get_context

Yields the SpanContext for this Span. Note that the return value of 
C<get_context()> is still valid after a call to L<finish()>, as is a call to
L<get_context()> after a call to L<finish()>.

    my $context = $span->get_context;
    

=head3 returns

An object that does the L<OpenTracing::Role::SpanContext> role.

=cut

around get_context => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'get_context';



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


around overwrite_operation_name => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'overwrite_operation_name';



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

The (finished) span, for chaining purposes.

=cut


around finish => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'finish';



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

around set_tag => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'set_tag';



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

around log_data => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'log_data';



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

around set_bagagge_item => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'set_bagagge_item';



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

around get_bagagge_item => sub {
    my $original  = shift;
    my $invocant  = shift;
    
    $original->( $invocant => ( @_ ) )
};

requires 'get_bagagge_item';

1;