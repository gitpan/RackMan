package RackMan::Format::PXE;

use strict;
use Carp;
use RackMan::File;
use RackMan::Template;


use constant {
    CONFIG_SECTION  => "format:pxe",
    DEFAULT_PATH    => "/etc/pxe/hosts",
    TEMPLATE_PATH   => "/etc/pxe/host.pxe.conf.tmpl",
};


#
# write()
# -----
sub write {
    my ($class, $args) = @_;

    my $rackdev = $args->{rackdev};
    my $rackman = $args->{rackman};
    my $config  = RackMan::File->new;

    # fetch the list of regular MAC addresses
    my @mac_addrs = $rackdev->regular_mac_addrs;

    # load and populate the template
    my $tmpl_path = $rackman->options->{pxe_template}
        || $rackman->config->val(CONFIG_SECTION, "template", TEMPLATE_PATH);
    print "  = reading $tmpl_path\n" if $args->{verbose};
    my $tmpl = RackMan::Template->new(filename => $tmpl_path);
    $tmpl->populate_from($rackdev, $rackman);

    # generate the config
    $config->add_content($tmpl->output);

    # write the configuration on disk
    (my $config_name = lc "01-$mac_addrs[0]{l2address_text}") =~ s/:/-/g;
    $config->name($config_name);
    $config->path($rackman->config->val(CONFIG_SECTION, "path", DEFAULT_PATH));
    print "  + writing ", $config->fullpath, $/ if $args->{verbose};
    my $scm = $rackman->get_scm({ path => $config->path });
    $scm->update;
    $config->write;
    $scm->add($config->name);
    $scm->commit($config->name, "generated by $class / $::PROGRAM v$::VERSION");
}


__PACKAGE__

__END__

=pod

=head1 NAME

RackMan::Format::PXE - Generate the PXE config for a given RackObject

=head1 SYNOPSIS

    use RackMan::Format::PXE;

    RackMan::Format::PXE->write({
        rackdev => $rackdev,  # a RackMan::Device instance
        rackman => $rackman,  # a RackMan instance
    });


=head1 DESCRIPTION

This module generates the PXE configuration file for a given RackObject,
based on a template provided by the user.


=head1 METHODS

=head2 write

Generate the file.

B<Arguments>

Arguments are expected as a hashref with the following keys:

=over

=item *

C<rackdev> - I<(mandatory)> a RackMan::Device instance

=item *

C<rackman> - I<(mandatory)> a RackMan instance

=item *

C<verbose> - I<(optional)> boolean, set to true to be verbose

=back


=head1 TEMPLATE PARAMETERS

See L<RackMan::Template/"TEMPLATE PARAMETERS"> for more details about
the available parameters.


=head1 CONFIGURATION

This module gets its configuration from the C<[format:dhcp]> section
of the main F<rack.conf>, with the following parameters:

=over

=item *

C<path> - specify the location to store the generated files

=item *

C<template> - specify the path of the template; can be overriden by
the C<--pxe-template> option

=back


=head1 SEE ALSO

L<RackMan::Template>


=head1 AUTHOR

Sebastien Aperghis-Tramoni

=cut

