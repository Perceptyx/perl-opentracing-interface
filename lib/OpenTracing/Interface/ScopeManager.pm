package OpenTracing::Interface::ScopeManager;

use strict;
use warnings;


our $VERSION = 'v0.206.0';


use Role::Declare::Should;

use OpenTracing::Types qw/Scope Span/;
use Types::Standard qw/Bool Dict Optional/;

use namespace::clean;


instance_method activate_span(
    Span $span,
    Bool :$finish_span_on_close, # should default to true
) :Return(Scope) {}



instance_method get_active_scope(
) :ReturnMaybe(Scope) {}



1;
