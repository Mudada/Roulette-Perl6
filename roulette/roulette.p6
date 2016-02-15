# Bonjour et bienvenu dans ma miserable tentative d'apprentissage du perl6

sub regle() {

    say "Les règles sont simple, vous avez une roulette de 36 chiffres (de 0 à 35) et un nombre est choisis aléatoirement à chaque tour.";
    say "De plus veuillez noter que les chiffres impaires sont de couleures rouge et les chiffres paires de couleures noires.\n";
    say "A chaque tour, il vous sera demander de miser de l'argent sur un nombre.\n";
    say "Si vous tombez sur le bon chiffre, vous remporter 3x la mise.";
    say "Si vous tombez sur un nombre de la meme couleur vous perdez la moitier de votre mise.";
    say "Dans le cas ou le nombre, n'a ni couleur ni chiffre en commun, vous perdez tout.";
}

sub play() {

    my $tour = 0;
    my $total = 200;
    
    loop {
	my $cmd = prompt "Combien voulez-vous miser ?\n";
	given $cmd {
	    when /quit/ {
		last;
		}
	    when /^\d+ $/ {
		if $total-$cmd >= 0 {
		    say "Vous avez misé $cmd votre total est maintenant de " ~$total-$cmd;
		    my $nb = lets_continue();
		    my $gain = get_roul($nb, $cmd);
		    $total = $total+$gain;
		    say "Votre nouveau total est, $total\n";
		}
	    }

	    default {
		affichage();
	    }
	}
    }
}

sub lets_continue(){

     loop {
	 my $nb = prompt "Sur quel nombre voulez-vous miser ?\n";
	 given $nb {
	     when /^\d+ $/ {
		 if $nb >= 0 && $nb <= 35 {
		     say "Vous avez miser sur le $nb";
		     return ($nb);
		 }
		 else { say "Rentrez un nombre correcte"; }
	     }
	     default { affichage(); }
	 }
     }
}

sub get_roul($nb, $cmd){

    my $rand = (0..35).rand.Int;
    my $gain = 0;

    say "La roulette donne $rand\n";
    if $rand == $nb {
	say "Vous avez gagné !!\n";
	$gain = $cmd*3;
    }
    else {
	if ($rand % 2 == 0) && ($nb % 2 == 0) {
	    say "Vous n'avez pas gagnez mais vos nombres sont de la meme couleure donc bon, ca compense :3";
	    $gain = ($cmd * -1) / 2;
	}
	elsif ($rand % 2 != 0) && ($nb % 2 != 0) {
	    say "Vous n'avez pas gagnez mais vos nombres sont de la meme couleure donc bon, ca compense :3";
	    $gain = ($cmd * -1) / 2;
	}
	else {
	    say "Perdu ...\n";
	    $gain = $cmd * -1;
	}
    }
    return ($gain);
 }

sub affichage($fin = -1) {

    if $fin == 0 {
	say "Bonjour et bienvenu dans ce premier programme en perl6.\nCe programme est comme sont nom l'indique une Roulette !\n";
	regle;
	say "Vous etes prets ? Non ? Tant pis. C'est partis pour le premier tour !!\n";
    }
    elsif $fin == 1 {
	say "Vous nous quittez déjà ? Bon est bien aurevoir alors.\n";
    }
    else {
	say "Il y à une erreur dans ce que vous avez rentrée.\n";
	}
}

affichage(0);
play();
