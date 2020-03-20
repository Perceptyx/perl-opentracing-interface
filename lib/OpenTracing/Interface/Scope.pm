package OpenTracing::Interface::Scope;


use strict;
use warnings;


our $VERSION = '0.10';


use Role::MethodReturns;



around close => instance_method ( ) {
    
    returns_self( $instance,
        
        $original->( $instance => ( ) )
        
    );
    
};



around get_span => instance_method ( ) {
    
    returns_object_does_interface( 'OpenTracing::Interface::Span' ,
        
        $original->( $instance => ( ) )
        
    )
};



1;
