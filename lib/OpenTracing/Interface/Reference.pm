package OpenTracing::Interface::Reference;


use strict;
use warnings;


our $VERSION = '0.10';


use Role::MethodReturns;

use Types::Interface qw/ObjectDoesInterface/;
use Types::Standard qw/Bool/;



around new_child_of => class_method (
    (ObjectDoesInterface['OpenTracing::Interface::SpanContext']) $span_context
) {
    
    returns_object_does_interface( 'OpenTracing::Interface::Reference' ,
        
        $original->( $class => ( $span_context ) )
        
    );
    
};



around new_follows_from => class_method (
    (ObjectDoesInterface['OpenTracing::Interface::SpanContext']) $span_context
) {
    
    returns_object_does_interface( 'OpenTracing::Interface::Reference' ,
        
        $original->( $class => ( $span_context ) )
        
    );
    
};



around get_referenced_context => instance_method ( ) {
    
    returns_object_does_interface( 'OpenTracing::Interface::SpanContext' ,
        
        $original->( $instance => ( ) )
        
    )
};



around type_is_child_of => instance_method ( ) {
    
    returns( Bool ,
        
        $original->( $instance => ( ) )
        
    )
};



around type_is_follows_from => instance_method ( ) {
    
    returns( Bool ,
        
        $original->( $instance => ( ) )
        
    )
};



1;
