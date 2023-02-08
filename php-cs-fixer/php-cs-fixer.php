<?php

// add the custom fixers.
require_once __DIR__ . '/vendor/wp-php-cs-fixer/loader.php';


$finder = PhpCsFixer\Finder::create()
	->exclude( 'node_modules' )
	->exclude( 'vendors' )
	->in( __DIR__ );

$config = new PhpCsFixer\Config();
$config
	->registerCustomFixers(
		array(
			new WeDevs\Fixer\SpaceInsideParenthesisFixer(),
			new WeDevs\Fixer\BlankLineAfterClassOpeningFixer(),
		)
	)
	->setRiskyAllowed( true )
	->setUsingCache( false )
	->setRules(
		WeDevs\Fixer\Fixer::rules()
	)
	->setIndent( "\t" )
	->setFinder( $finder );

return $config;
