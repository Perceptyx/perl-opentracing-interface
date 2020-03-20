## COPYRIGHT NOTICE

'OpenTracing API for Perl' is Copyright (C) 2019, Perceptyx Inc, Theo van Hoesel

# OpenTracing API for Perl

This package describes the OpenTracing API for Perl

## Required Reading

In order to understand the Perl platform API, one must first be familiar with
[the OpenTracing project](http://opentracing.io/)
and
[terminology](http://opentracing.io/documentation/pages/spec)
more generally.

## Usage

### Initialize the Tracer Singleton

```perl
use OpenTracing::Implementation qw/YourTracingService/;
```

### Access the Tracer Singleton

```perl
use OpenTracing::GlobalTracer qw/$TRACER/;
```

### Direct control over Tracing instead of using singletons

```perl
use YourImplementation::Tracer;

my $TRACER = YourImplementation::Tracer->new( %options );
```

### Add a new span inside a subroutine

```perl
sub some_work {
    my $opentracing_scope =
        $TRACER->start_active_span( 'some_operation_name' );
    
    ...
    
    $opentracing_scope->close
    
    return ...
}
```

### Inject a SpanContext into an outgoing request:

```perl
my $opentracing_spancontext = $TRACER->get_active_span->get_context;

use HTTP::Headers;
my $http_headers = HTTP::Headers->new( ... );

$TRACER->inject_context( $opentracing_spancontext,
    OPENTRACING_FORMAT_HTTP_HEADERS => $http_headers
);

my $request = HTTP::Request->new( GET => 'https://...', $headers);
my response = LWP::UserAgent->request( $request );
```

### Extract a SpanContext from an incoming request

```perl
use YourFramework;

get '/some_service' => sub {
    my $http_headers = YourFramework->request->headers;
    
    my $opentracing_context = $TRACER->extract_context(
        OPENTRACING_FORMAT_HTTP_HEADERS => $http_headers
    );
    
    ...
    
}
```

## About

The interfaces being defined as roles
( using [Role::Tiny](https://metacpan.org/pod/Role::Tiny) )
and use `around` method modifiers, instead of `require`, we do want to wrap the
method in type checking
( using [Type::Tiny](https://metacpan.org/pod/Type::Tiny) and friends ).


## LICENSE INFORMATION

This library is free software; you can redistribute it and/or modify it under
the terms of the Artistic License 2.0.

This library is distributed in the hope that it will be useful, but it is
provided “as is” and without any express or implied warranties.

For details, see the full text of the license in the file LICENSE.

