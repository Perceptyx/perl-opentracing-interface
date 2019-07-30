package OpenTracing::Role::Implementor;

use Role::Tiny;

=head1 NAME

OpenTracing::Role::Implementor - A role that defines the Implementor interface

=head1 METHODS

=cut

=head2 set_global_tracer( $tracer )

Sets the GlobalTracer singleton to a specific implementation

    my $tracer = OpenTracing->set_global_tracer(
        My::Tracer::Implentation->new( ... ),
    );
    

head3 params

=over

=item tracer

An object that does the L<OpenTracing::Role::Tracer> role.

=back

=head3 returns

The tracer object

=cut

around set_global_tracer => sub {
    my $original = shift;
    my $invocant = shift;
    
    $original->( $invocant->(@_) )
};

=head2 get_global_tracer

Gets the GlobalTracer

    my $tracer = OpenTracing->get_global_tracer( );
    

=cut

around get_global_tracer => sub {
    my $original = shift;
    my $invocant = shift;
    
    $original->( $invocant->(@_) )
};

1;
