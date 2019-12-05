package OpenTracing::Interface::ScopeManager;

use strict;
use warnings;


use OpenTracing::ReadableInterface;

use Types::Interface qw/ObjectDoesInterface/;
use Types::Standard qw/Bool Maybe/;



around activate_span => instance_method (
    (ObjectDoesInterface['OpenTracing::Interface::Span']) $span,
    Bool $finish_span_on_close,
) {
    
    returns_object_does_interface( 'OpenTracing::Interface::ScopeGuard',
        $original->( $instance => ( $finish_span_on_close ) )
    )

}; # deprecate this, don't pass in booleans or switches, make it explicit

# around activate_but_do_not_close_on_finish

# around activate_and_close_on_finish



around get_active_scope => instance_method ( ) {
    
    returns_object_does_interface( 'OpenTracing::Interface::ScopeGuard',
        $original->( $instance => ( ) )
    )
};


1;
