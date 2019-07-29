# OpenTracing API for Perl

This package describes the OpenTracing API for Perl

## Required Reading

In order to understand the Perl platform API, one must first be familiar with
[the OpenTracing project](http://opentracing.io/)
and
[terminology](http://opentracing.io/documentation/pages/spec)
more generally.

## Usage

### Singleton initialization

The simplest starting point is to set the global tracer. As early as possible,
do:

```perl
use OpenTracing;

OpenTracing->set_global_tracer( SomeTracerImplementation->new( ... ) );
```
