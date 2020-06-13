package OpenTracing::Interface::Span;

use strict;
use warnings;


our $VERSION = 'v0.201.0';


use Role::Declare -lax;

use OpenTracing::Types qw/SpanContext/;
use Types::Standard qw/Str Value HashRef ArrayRef Maybe/;
use Types::Common::Numeric qw/PositiveNum PositiveOrZeroNum/;

use namespace::clean;


instance_method get_context(
) :Return(SpanContext) {}



instance_method overwrite_operation_name(
    Str $operation_name
) :ReturnSelf {}



instance_method finish(
    Maybe[PositiveOrZeroNum] $time_stamp,
) :ReturnSelf {}



instance_method set_tag(
    Str $key,
    Value $value
) :ReturnSelf {}



instance_method log_data(
    @log_data
) :ReturnSelf {
    ( HashRef[ Value ] )->assert_valid( { @log_data } );
}



instance_method set_baggage_item(
    Str $key,
    Value $value
) :ReturnSelf {}



instance_method get_baggage_item(
    Str $key
) :ReturnMaybe(Value) {}



1;
