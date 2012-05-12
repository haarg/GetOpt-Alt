#!/usr/bin/perl -w

BEGIN { $ENV{TESTING} = 1 }

use strict;
use warnings;
use List::Util qw/sum/;
use Test::More;
#use Test::NoWarnings;
use Getopt::Alt::Option;
use Data::Dumper qw/Dumper/;

my @valid = (
    'test' => {
        names => [qw/test /],
        name  => 'test',
    },
    'test|other' => {
        names => [qw/test other /],
    },
    'test|other|o' => {
        names => [qw/test other o /],
        name  => 'test',
    },
    'test|t=s' => {
        type => 'Str',
    },
    'test|t=i' => {
        type => 'Int',
    },
    'test|t=f' => {
        type => 'Num',
    },
    'inc+' => {
        increment => 1,
    },
    'neg!' => {
        negatable => 1,
    },
    'null?' => {
        nullable => 1,
    },
);
my @bulk = get_bulk();

my %valid = @valid;
my $tests = ( sum map {scalar keys %{$valid{$_}} } keys %valid );
plan tests => $tests + @bulk;# + 1;

for ( my $i = 0; $i < @valid; $i += 2 ) {
    my $args  = $valid[$i];
    my $tests = $valid[$i+1];
    my $opt   = Getopt::Alt::Option->new( $args );

    for my $key ( keys %{ $tests } ) {
        is_deeply( $opt->$key(), $tests->{$key}, "$args -> $tests->{$key}" ) or BAIL_OUT(1);
        #diag Dumper $opt, $opt->$key();
        #diag Dumper $opt->$key(), $tests->{$key};
    }
}

for my $valid (@bulk) {
    my $opt = eval{ Getopt::Alt::Option->new($valid) };
    diag Dumper $@ if $@;
    ok($opt, "'$valid' loads");
}

sub get_bulk {
    return (
          '1=i%'
        , '256|c=i%'
        , '2=i%'
        , '3=i%'
        , 'add|a=s@'
        , 'add_only|a'
        , 'after|a=s'
        , 'against|a=s'
        , 'all|a'
        , 'all_line|all-line|A'
        , 'apache2|a'
        , 'arg|a=s%'
        , 'ask|a'
        , 'author|a'
        , 'author|authortests|a'
        , 'autocomplete'
        , 'back|trimback|b=s'
        , 'base=s'
        , 'bell|b'
        , 'breaks|b'
        , 'bydate|b'
        , 'bydate|d'
        , 'byte|b'
        , 'calendar_height|height|h=s'
        , 'cat|C'
        , 'change|c=i'
        , 'changer|c=s'
        , 'changes|c=i'
        , 'chdir|d'
        , 'clean|distclean|c'
        , 'cmd|command|c=s'
        , 'col|c=i'
        , 'colour|colourspace|c=s'
        , 'colour_number|cnum=s'
        , 'colour_number_surround|cnumout=s'
        , 'cols|columns|c=s@'
        , 'column|c=s'
        , 'columns|c=i'
        , 'columns|C=i'
        , 'command|c=s'
        , 'config|conf|c=s'
        , 'config|C=s'
        , 'conf=s'
        , 'count|c'
        , 'countdown|c=i'
        , 'count|n'
        , 'cp|cpmissing|m'
        , 'cpu|c'
        , 'create|c'
        , 'current|c'
        , 'database|d=s'
        , 'date|d=s'
        , 'date|d=s%'
        , 'db|d'
        , 'db_host|dbhost|h=s'
        , 'dblong|l'
        , 'db_name|dbname|n=s'
        , 'db_pass|dbpass|u=s'
        , 'db_port|dbport|p=s'
        , 'db_user|dbuser|u=s'
        , 'decending|d'
        , 'delete|d'
        , 'deleted|d=s@'
        , 'describe|d'
        , 'destination|d'
        , 'destination|d=s'
        , 'dict|d=s'
        , 'die|d=i'
        , 'diffargs|a=s'
        , 'diff|d'
        , 'diff|diffcmd|d=s'
        , 'diff|d=s'
        , 'dir|d=s'
        , 'dirfirst|d'
        , 'dirs|dir|d=s@'
        , 'dirs|d=s@'
        , 'display|d=s%'
        , 'dos|d'
        , 'dump|D'
        , 'exclude|e=s'
        , 'Exclude|E=s'
        , 'exists|e'
        , 'expand|e'
        , 'file_contains=s'
        , 'file_exclude|exclude|x=s@'
        , 'file_exclude_type|exclude_type|ext|X=s@'
        , 'file|f=s'
        , 'file|F=s@'
        , 'file_ignore_add|d=s'
        , 'file_ignore_remove|r=s'
        , 'file_ignore=s'
        , 'file_include|include|n=s@'
        , 'file_include_type|include_type|int|N=s@'
        , 'file_not_contains=s'
        , 'file_recurse|R'
        , 'files'
        , 'files|f'
        , 'files|file|f=s@'
        , 'files|f=s'
        , 'Files|F=s'
        , 'file_symlinks|links|l'
        , 'filter|l=s%'
        , 'fix|f'
        , 'follow|f'
        , 'follow|l'
        , 'follow_links|follow-links|L'
        , 'followsymlinks'
        , 'force|f'
        , 'force|f|nonew'
        , 'force_title|force-title|f'
        , 'fork|f'
        , 'fork'
        , 'four|f'
        , 'front|trim-front|f=s'
        , 'function|f=s@'
        , 'game|g=s'
        , 'gigabyte|g'
        , 'global|G'
        , 'group|g=s'
        , 'gzip|g|bzip2|j'
        , 'height|h=i'
        , 'help'
        , 'help|h'
        , 'home|h'
        , 'host|h=s'
        , 'host=s'
        , 'human|h'
        , 'ical|c=s%'
        , 'ignore|i=s'
        , 'ignore|i=s@'
        , 'image|i=s%'
        , 'include|I|i=s@'
        , 'include|i=s'
        , 'include|I=s@'
        , 'indent|i=i'
        , 'indent|i=s'
        , 'indenttype=s'
        , 'infolder|i=s@'
        , 'in|i'
        , 'in|i=s'
        , 'insensitive|i'
        , 'install|i=s'
        , 'interactice|i'
        , 'i=s%'
        , 'itterations|i=i'
        , 'join|j'
        , 'j=s%'
        , 'keepalive|k'
        , 'kill|k'
        , 'kilobyte|k'
        , 'k=s%'
        , 'length|l=i'
        , 'level|l=i'
        , 'limit|l=i'
        , 'limit|l=n'
        , 'line|l=i'
        , 'lineno|width|W=i'
        , 'links|l'
        , 'list_dir|d=s'
        , 'list_file|f=s'
        , 'list|l'
        , 'list|ls|l'
        , 'live|l=i'
        , 'llines|long-lines|l=i'
        , 'local|l=s'
        , 'lop|l=s'
        , 'l=s%'
        , 'ltime|longtime|t=i'
        , 'makefile|m'
        , 'man'
        , 'man|m'
        , 'match|m=s'
        , 'max|a=i'
        , 'max_memory|max-memory|m=f'
        , 'max|m=i'
        , 'maxtime|m=i'
        , 'mech|mechanize|M'
        , 'megabyte|m'
        , 'mem|m'
        , 'minfiles|minfiles|f=i'
        , 'min|i=i'
        , 'min|m=i'
        , 'minsize|minsize|s=i'
        , 'module|m=s'
        , 'monitor|M'
        , 'moon|m=s%'
        , 'mysql|m=s'
        , 'name|n'
        , 'name|n=s'
        , 'names|N'
        , 'names|namesonly|n'
        , 'new|n'
        , 'no_clean_split'
        , 'nogeom|ng'
        , 'nonewdir|n'
        , 'number|n=i'
        , 'one|o'
        , 'order|orderby|o=s'
        , 'original|o'
        , 'other|o'
        , 'other=s'
        , 'out_files_only|files-only|f'
        , 'outfolder|o=s'
        , 'out_limit|limit=i'
        , 'out|o=s'
        , 'out=s'
        , 'out_suround_after|after|a=n'
        , 'out_suround_before|before|b=n'
        , 'out_suround|suround|s=n'
        , 'out_totals|totals|t'
        , 'out_unique|unique|u'
        , 'page|p=s%'
        , 'params|p=s%'
        , 'password|p=s'
        , 'password|W'
        , 'path|p=s'
        , 'path|p=s@'
        , 'path|P=s'
        , 'pause|p=i'
        , 'pipe|P'
        , 'player|p=s'
        , 'port|p=i'
        , 'port|p=s'
        , 'port=s'
        , 'project|P=s'
        , 'psql|p=s'
        , 'pull|p'
        , 'range|r=s'
        , 'recurse|r'
        , 'remember|R'
        , 'replace|r=s'
        , 'replay|R'
        , 'reset|r=s'
        , 'restartdelay|rd=s'
        , 'restartdirectory=s@'
        , 'restart|r'
        , 'restartregex|rr=s'
        , 'restart|r'
        , 'revision|r=s'
        , 'rule|m=s'
        , 'same|samefiles|S'
        , 'save|s'
        , 'schema|s=s'
        , 'scp|s=s@'
        , 'screen_saver|ss|s'
        , 'script|s'
        , 'scripts|s'
        , 'search=s'
        , 'search|s=s'
        , 'sections|s=i'
        , 'serial|s'
        , 'server|S=s'
        , 'servers|s=s@'
        , 'service|s=s'
        , 'service|s=s@'
        , 'sessionnumber|N=i'
        , 'session|s=s'
        , 'short|S'
        , 'show|showchanges|s'
        , 'showtemplate'
        , 'sigfile|m=s'
        , 'simple|S'
        , 'simplify|s'
        , 'skip|k=s@'
        , 'skip|re|r=s'
        , 'skip|s=s@'
        , 'slines|shortlines|L=i'
        , 'smaller|s'
        , 'sort|s'
        , 'source|s=s'
        , 'spaces|s'
        , 'sre_all|all|A'
        , 'sre_ignore_case|ignore|i'
        , 'sre_last|last|L=s@'
        , 'sre_smart|smart|m'
        , 'sre_sub_matches|contains|c=s@'
        , 'sre_sub_no_matches|not-contains|notcontains|S=s@'
        , 'sre_whole|whole|w'
        , 'sre_words|words|W'
        , 'stdin|I'
        , 'stime|shorttime|s=i'
        , 'style|s=s'
        , 'submit|s'
        , 'sudo|d=s'
        , 'summary|s'
        , 'suround|s=i'
        , 'suround|s=n'
        , 'table|t=s'
        , 'tabs|t'
        , 'tail|T=s'
        , 'taint|T'
        , 'tar|t'
        , 'task|t=s'
        , 'template|t=s'
        , 'terabyte|t'
        , 'test'
        , 'test|t'
        , 'test|T'
        , 'time|t=i'
        , 'time|t=s'
        , 'total|T'
        , 'type|t=s'
        , 'unicode_length|unicode-length|U'
        , 'unicode|u'
        , 'username|u=s'
        , 'username|U=s'
        , 'user|u=s'
        , 'uses|u'
        , 'vcs|c=s'
        , 'verbose'
        , 'verbose|v'
        , 'verbose|verbose|v'
        , 'VERSION'
        , 'VERSION|V'
        , 'vimdiff|v'
        , 'warn|w'
        , 'whole|wholeword|w'
        , 'width|w=i'
        , 'win|w'
        , 'words|d'
        , 'words|w=s'
        , 'wrap|w'
        , 'write|w'
    );
}
