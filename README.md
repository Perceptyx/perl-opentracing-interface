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
## About

The interfaces are being defined as roles ( using L<Role::Tiny> ) and use
C<around> method modifiers, instead of C<require>, we do want to wrap the method
in type checking ( using L<Type::Tiny> and friends ).
