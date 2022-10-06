<?php

return PhpCsFixer\Config::create()
    ->setRiskyAllowed(true)
    ->setRules([
        '@PSR2'               => true,
        '@Symfony'            => true,
        '@DoctrineAnnotation' => true,
        '@PhpCsFixer'         => true,
        'array_syntax' => [
            'syntax' => 'short',
        ],
        'list_syntax' => [
            'syntax' => 'short',
        ],
        'concat_space' => [
            'spacing' => 'one',
        ],
        'no_superfluous_phpdoc_tags' => [
            'allow_mixed' => false,
        ],
        'blank_line_before_statement' => [
            'statements' => [
                'declare',
            ],
        ],
        'binary_operator_spaces' => [
            'operators' => [
                '=>' => 'align',
            ],
        ],
        'general_phpdoc_annotation_remove' => [
            'annotations' => [
                'author',
            ],
        ],
        'list_syntax' => [
            'syntax' => 'short',
        ],
        'yoda_style' => [
            'always_move_variable' => true,
            'equal'                => true,
            'identical'            => true,
        ],
        'multiline_whitespace_before_semicolons' => [
            'strategy' => 'no_multi_line',
        ],
        'single_line_comment_style' => [
            'comment_types' => ['hash'],
        ],
        'class_attributes_separation'       => true,
        'combine_consecutive_unsets'        => true,
        'declare_strict_types'              => false,
        'linebreak_after_opening_tag'       => true,
        'lowercase_constants'               => true,
        'lowercase_static_reference'        => true,
        'no_useless_else'                   => true,
        'no_unused_imports'                 => true,
        'not_operator_with_successor_space' => false,
        'not_operator_with_space'           => false,
        'ordered_class_elements'            => true,
        'ordered_imports'                   => true,
        'php_unit_strict'                   => false,
        'phpdoc_separation'                 => false,
        'single_quote'                      => true,
        'standardize_not_equals'            => true,
    ])
    ->setFinder(
        PhpCsFixer\Finder::create()
            ->exclude('public')
            ->exclude('resources')
            ->exclude('config')
            ->exclude('runtime')
            ->exclude('vendor')
            ->in(__DIR__)
    )
    ->setUsingCache(false);
