package OpenTracing::Interface::Tracer;


use strict;
use warnings;

use OpenTracing::ReadableInterface;

use Types::Standard qw/Int Maybe Str Value HashRef Dict ArrayRef Bool Optional/;
use Types::Common::Numeric qw/PositiveNum/;
use Types::Interface qw/ObjectDoesInterface/;



around get_scope_manager => instance_method ( ) {
    
    returns_maybe_object_does_interface( 'OpenTracing::Interface::ScopeManager',
        
        $original->( $instance => ( ) )
        
    )
};



around get_active_span => instance_method ( ) {
    
    returns_maybe_object_does_interface( 'OpenTracing::Interface::Span',
        
        $original->( $instance => ( ) )
        
    )
};



around start_acitve_span => instance_method ( Str  $operation_name, %options ) {
    
    ( Dict[
        
        child_of            => Optional[
            ObjectDoesInterface['OpenTracing::Interface::Span']        |
            ObjectDoesInterface['OpenTracing::Interface::SpanContext']
        ],
        references          => Optional[ ArrayRef[ HashRef ]],
        tags                => Optional[ HashRef ],
        start_time          => Optional[ PositiveNum ],
        ignore_active_span  => Optional[ Bool ],
        
    ] )->assert_valid( \%options );
    

{ use Data::Dumper; local $Data::Dumper::Sortkeys = 1; warn Dumper(@_) . "\n"; } # XXX REMOVE ME

    returns_object_does_interface( 'OpenTracing::Interface::ScopeGuard',
    
        $original->( $instance => ( $operation_name, %options ) )
    )
};



1;
