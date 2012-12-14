package RackTables::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use Moose;
use namespace::autoclean;
extends 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-26 11:34:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XGREd2jOR57+DSXsUdUzRw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable(inline_constructor => 0);

__END__

=pod

=head1 NAME

RackTables::Schema - Base class for RackTables schema

=head1 SYNOPSIS

    my $racktables = RackTables::Schema->connect($dsn, $user, $password);


=head1 DESCRIPTION

This module is the base class of the RackTables schema, generated by
the B<dbicdump(1)> program (part of C<DBIx::Class::Schema::Loader>),
from a RackTables v0.19.9 database. As such, it inherits everything
from C<DBIx::Class::Schema>.


=head1 SEE ALSO

L<DBIx::Class>, L<DBIx::Class::Schema>, L<DBIx::Class::Schema::Loader>


=head1 AUTHOR

Sebastien Aperghis-Tramoni

=cut