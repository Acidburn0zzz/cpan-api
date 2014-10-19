package MetaCPAN::Server::Controller::Module;

use strict;
use warnings;

use Moose;

BEGIN { extends 'MetaCPAN::Server::Controller::File' }

has '+type' => ( default => 'file' );

sub get : Path('') : Args(1) {
    my ( $self, $c, $name ) = @_;
    my $file = $self->model($c)->raw->find($name);
    if ( !defined $file ) {
        $c->detach( '/not_found', [] );
    }
    $c->stash( $file->{_source} || $file->{fields} )
        || $c->detach( '/not_found',
        ['The requested field(s) could not be found'] );
}

__PACKAGE__->meta->make_immutable();
1;
