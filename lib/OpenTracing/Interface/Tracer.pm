package OpenTracing::Interface::Tracer;


use strict;
use warnings;


our $VERSION = '0.19';


use Role::Declare -lax;

use OpenTracing::Types qw/ContextReference Scope ScopeManager Span SpanContext/;
use Types::Standard qw/Maybe Any ArrayRef Bool Dict HashRef Optional Str/;
use Types::Common::Numeric qw/PositiveOrZeroNum/;

use Carp;

use namespace::clean;


instance_method get_scope_manager(
) :Return(ScopeManager) {}



instance_method get_active_span(
) :ReturnMaybe(Span) {}



instance_method start_active_span(
    Str $operation_name,
    Maybe[ Span | SpanContext ]         :$child_of,
    Maybe[ ArrayRef[ContextReference] ] :$references,
    Maybe[ HashRef[Str] ]               :$tags,
    Maybe[ PositiveOrZeroNum ]          :$start_time,
    Maybe[ Bool ]                       :$ignore_active_span,
    Maybe[ Bool ]                       :$finish_span_on_close, # should default to true
) :Return(Scope) {
    croak "'child_of' and 'references' are mutual exclusive options"
        if defined $child_of && defined $references;
};



instance_method start_span(
    Str $operation_name,
    Maybe[ Span | SpanContext ]         :$child_of,
    Maybe[ ArrayRef[ContextReference] ] :$references,
    Maybe[ HashRef[Str] ]               :$tags,
    Maybe[ PositiveOrZeroNum ]          :$start_time,
    Maybe[ Bool ]                       :$ignore_active_span,
) :Return(Span) {
    croak "'child_of' and 'references' are mutual exclusive options"
      if defined $child_of && defined $references;
};



instance_method inject_context(
    $carrier_format,
    $carrier,
    SpanContext $span_context
) {}



instance_method extract_context(
    $carrier_format,
    $carrier
) :ReturnMaybe(SpanContext) {}



1;
