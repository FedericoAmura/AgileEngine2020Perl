#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Auxiliary libraries
use Mojo::DOM;
use Mojo::File;

my $origin = $ARGV[0]; # The file where we will get original element
my $search = $ARGV[1]; # The file where we need to find the modified original element

# We will use the original button href reference as the first word of the JS method called
# (We could just hardcode it, parse method name or compare method names to find similarities
# but this approach may be more versatile as the href dictates the kind of method we are interested in)
# The methods called are okDone, okComplete and okFinalize; in summary okXxxx
# There are other buttons, but not the ones we want, that claim and get the "ok" href, so we cannot use the href
# But there is not other button, except the ones we want, that have some method with that kind of name

# Load the original file into memory
my $originFile = Mojo::File->new($origin);
my $originalDom = Mojo::DOM->new($originFile->slurp);

# Get its href reference
my $originalOkButton = $originalDom->at('#make-everything-ok-button');
my $href = substr $originalOkButton->attr("href"), 1;

# Load the new modified file into memory
my $searchFile = Mojo::File->new($search);
my $searchDom = Mojo::DOM->new($searchFile->slurp);

# We search for button with onclick attribute ".okXxxx"
my $searchButton = ($searchDom->find("a[class~=btn]")->grep(sub {
    ($_->attr("onclick") or "") =~ /\Q$href/; # /ok/;
})->each)[0];

# Get its ancestors as an array
my @searchButtonAncestors = $searchButton->ancestors->map('tree')->each;
my @path = reverse(map { $$_[1] } @searchButtonAncestors); # reverse it and mapping to only the element tag

# Printing path as expected
my $printPath = join " > ", @path;
print "$printPath > a";