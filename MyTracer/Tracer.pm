package MyTracer::Tracer;

use MyTracer::ScopeGuard;
use MyTracer::ScopeManager;

sub new {
    my $class = shift;
    my %data = @_;
    
    my $self = \%data;
    
    return bless $self, $class
}

sub get_active_span { ... }

sub start_acitve_span {

{ use Data::Dumper; local $Data::Dumper::Sortkeys = 1; warn Dumper(@_) . "\n"; } # XXX REMOVE ME

    my $self = shift;
    
    MyTracer::ScopeGuard->new( );
}

sub get_scope_manager { 
    my $self = shift;
    
    MyTracer::ScopeManager->new( );
}

BEGIN {
    
    use Role::Tiny::With;

    with OpenTracing::Interface::Tracer;

}



1;
