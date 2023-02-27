<?php
/**
 * PHP CS Fixer config
 */

/** Add the custom fixers. */
if ( file_exists( __DIR__ . '/vendor/tareq1988/wp-php-cs-fixer/loader.php' ) ) {
	require_once __DIR__ . '/vendor/tareq1988/wp-php-cs-fixer/loader.php';
} elseif ( file_exists( getenv( 'HOME' ) . '/.config/composer/vendor/tareq1988/wp-php-cs-fixer/loader.php' ) ) { // phpcs:ignore WordPress.Security.ValidatedSanitizedInput
	require_once getenv( 'HOME' ) . '/.config/composer/vendor/tareq1988/wp-php-cs-fixer/loader.php'; // phpcs:ignore WordPress.Security.ValidatedSanitizedInput
}

$rules = WeDevs\Fixer\Fixer::rules(); // phpcs:ignore WordPress.NamingConventions.PrefixAllGlobals

$rules = array( // phpcs:ignore WordPress.NamingConventions.PrefixAllGlobals
	'phpdoc_add_missing_param_annotation' => true,
	'phpdoc_no_package'                   => false,
	'phpdoc_types'                        => array(
		'groups' => array( 'simple', 'alias', 'meta' ),
	),
);

$finder = PhpCsFixer\Finder::create() // phpcs:ignore WordPress.NamingConventions.PrefixAllGlobals
->exclude( 'node_modules' )
->exclude( 'vendors' )
->in( __DIR__ );

$config = new PhpCsFixer\Config(); // phpcs:ignore WordPress.NamingConventions.PrefixAllGlobals

$config
->registerCustomFixers(
	array(
		new WeDevs\Fixer\SpaceInsideParenthesisFixer(),
		new WeDevs\Fixer\BlankLineAfterClassOpeningFixer(),
	)
)
->setRiskyAllowed( true )
->setUsingCache( false )
->setRules( $rules )
->setIndent( "\t" )
->setFinder( $finder );

return $config;
