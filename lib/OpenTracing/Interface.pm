package OpenTracing::Interface;

use Carp;

BEGIN {
    carp <<END_OF_MESSAGE;
Do not 'use' "OpenTracing::Interface" !!!

it does not provide anything!
check the documnentationon how to consume the roles provided
END_OF_MESSAGE

}

our $VERION = "0.16";

1;
