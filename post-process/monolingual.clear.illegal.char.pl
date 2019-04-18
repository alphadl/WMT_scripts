#!/usr/bin/perl -w


use strict;
use Encode;
use utf8;

my $logo =   "########### SCRIPT ########### SCRIPT ############ SCRIPT ##########\n".
             "#                                                                   #\n".
             "#  USYD.NLP Group _________________ clean monolingual illegal tool  #\n".
             "#                                                                   #\n".
             "########### SCRIPT ########### SCRIPT ############ SCRIPT ##########\n";

print STDERR $logo;

my %param;

getParameter( @ARGV );

open( TGTINFILE, "<", $param{ "-tgt" } ) or die "Error: can not read file $param{ \"-tgt\" }.\n";
open( OUTTGTFILE, ">", $param{ "-outTgt" } ) or die "Error: can not write file $param{ \"-outTgt\" }.\n";
open( OUTTGTFILEDISCARD, ">", $param{ "-tgt" }.".discard" ) or die "Error: can not write file $param{ \"-outTgt\" }.illegalchar.\n";

print STDERR "Start filter with illegal char:\n";
my $lineNo = 0;
my $reservedNum = 0;
my $nullNum = 0;
my $illegalCharNum = 0;
my $tgtInFile = "";
while( $tgtInFile = <TGTINFILE> )
{
    ++$lineNo;

    $tgtInFile =~ s/[\r\n]//g;
    $tgtInFile =~ s/\t/ /g;
    $tgtInFile =~ s/ +/ /g;
    $tgtInFile =~ s/^ +//;
    $tgtInFile =~ s/ +$//;
    
    if( $tgtInFile eq "" )
    {
        ++$nullNum;
        print OUTTGTFILEDISCARD "[$lineNo NULL] $tgtInFile\n";
        next;
    }
    elsif( ( $param{ "-lang" } eq "en" ) && !( $tgtInFile =~ /^[[:ascii:]]+$/ ) )
    {
        ++$illegalCharNum;
        print OUTTGTFILEDISCARD "[$lineNo UNASCII] $tgtInFile\n";
    }
    elsif( $tgtInFile =~ /[[:cntrl:]]/ )
    {
        ++$illegalCharNum;
        print OUTTGTFILEDISCARD "[$lineNo CONTROLE] $tgtInFile\n";    
    }
    else
    {
        ++$reservedNum;
        print OUTTGTFILE "$tgtInFile\n";
    }
    
    print STDERR "\r    [LINENO=$lineNo RESERVED=$reservedNum DIS=$illegalCharNum NULL=$nullNum]" if $lineNo % 10000 == 0;
}
print STDERR "\r    [LINENO=$lineNo RESERVED=$reservedNum DIS=$illegalCharNum NULL=$nullNum]\n";

close( TGTINFILE );
close( OUTTGTFILE );
close( OUTTGTFILEDISCARD );


sub getParameter
{
          if( ( scalar( @_ ) < 4 ) || ( scalar( @_ ) % 2 != 0 ) )
          {
                    print STDERR "[USAGE]\n".
                                 "         monolingualclear.illegal.char.pl [OPTIONS]\n".
                                 "[OPTION]\n".
                                 "          -tgt    :  Target Output File.\n".
                                 "          -outTgt :  Output Filtered Target File.\n".
                                 "          -lang   :  Language, \"en\" or \"zh\"        [optional]\n".
                                 "                       Default value is \"en\".\n".
                                 "[EXAMPLE]\n".
                                 "         perl clear.illegal.char.pl       [-tgt    FILE]\n".
                                 "                                          [-outTgt FILE]\n".
                                 "                                          [-lang   PARA]\n";
                    exit( 0 );
          }
          
          my $pos;
          for( $pos = 0; $pos < scalar( @_ ); ++$pos )
          {
                    my $key = $ARGV[ $pos ];
                    ++$pos;
                    my $value = $ARGV[ $pos ];
                    $param{ $key } = $value;
          }
                    
          if( !exists $param{ "-tgt" } )
          {
                    print STDERR "Error: please assign \"-tgt\"!\n";
                    exit( 1 );
          }
                    
          if( !exists $param{ "-outTgt" } )
          {
                    print STDERR "Error: please assign \"-outTgt\"!\n";
                    exit( 1 );
          }
          
          if( !exists $param{ "-lang" } )
          {
                    $param{ "-lang" } = "en";
          }
}
