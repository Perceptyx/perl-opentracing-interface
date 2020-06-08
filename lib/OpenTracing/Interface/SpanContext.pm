package OpenTracing::Interface::SpanContext;


use strict;
use warnings;


our $VERSION = '0.20';


use Role::Declare;

use OpenTracing::Types qw/SpanContext/;
use Types::Standard qw/Str Value/;

use namespace::clean;


instance_method get_baggage_item(
    Str $key
) :ReturnMaybe(Value) {}



instance_method with_baggage_item(
    Str $key,
    Str $value
) :Return(SpanContext) {}


1;
