package OpenTracing::Role::Tracer;

use Role::Tiny;

=head1 NAME

OpenTracing::Role::Tracer - A role that defines the Tracer interface

=head1 METHODS

=cut

=head2 set( $tracer )

Sets the GlobalTracer singleton to a specific implementation

    my $tracer = OpenTracing->set(
        My::Tracer::Implentation->new( ... ),
    );
    

=head3 params

=over

=item tracer

An object that does the L<OpenTracing::Role::Tracer> role.

=back

=head3 returns

The tracer object

=cut

around set => sub {
    my $original = shift;
    my $invocant = shift;
    
    $original->( $invocant->(@_) )
};

requires 'set';

=head2 get

Gets the GlobalTracer

    my $tracer = OpenTracing->get( );
    

=cut

around get => sub {
    my $original = shift;
    my $invocant = shift;
    
    $original->( $invocant->(@_) )
};

requires 'get_global_tracer';

1;
