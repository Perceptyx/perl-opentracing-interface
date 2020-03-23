package OpenTracing::Types;

=head1 NAME

OpenTracing::Types - Type constraints for checking Interfaces

=cut

use Type::Library -base;
use Type::Utils qw/duck_type/;

use constant {
    REQUIRED_METHODS_FOR_REFERENCE => [ qw(
        new_child_of
        new_follows_from
        get_referenced_context
        type_is_child_of
        type_is_follows_from
    ) ],
    REQUIRED_METHODS_FOR_SCOPE => [ qw(
        close
        get_span
    ) ],
    REQUIRED_METHODS_FOR_SCOPEMANAGER => [ qw(
        activate_span
        get_active_scope
    ) ],
    REQUIRED_METHODS_FOR_SPAN => [ qw(
        get_context
        overwrite_operation_name
        finish
        set_tag
        log_data
        set_baggage_item
        get_baggage_item
    ) ],
    REQUIRED_METHODS_FOR_SPANCONTEXT => [ qw(
        get_baggage_item
        with_baggage_item
    ) ],
    REQUIRED_METHODS_FOR_TRACER => [ qw(
        get_scope_manager
        get_active_span
        start_active_span
        start_span
        inject_context
        extract_context
    ) ],
};




duck_type Reference    => REQUIRED_METHODS_FOR_REFERENCE;
duck_type Scope        => REQUIRED_METHODS_FOR_SCOPE;
duck_type ScopeManager => REQUIRED_METHODS_FOR_SCOPEMANAGER;
duck_type Span         => REQUIRED_METHODS_FOR_SPAN;
duck_type SpanContext  => REQUIRED_METHODS_FOR_SPANCONTEXT;
duck_type Tracer       => REQUIRED_METHODS_FOR_TRACER;



1;

