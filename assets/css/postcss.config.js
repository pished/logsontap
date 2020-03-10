const themeDir = __dirname + '/../../';

module.exports = {    
    plugins: [        
        require('postcss-import')({
            path: ["assets/css"]
            }), 
        require('tailwindcss')('assets/css/tailwind.config.js'),
        require('@fullhuman/postcss-purgecss')({
            content: [
                'layouts/**/*.html',
                'content/**/*.html'
            ],
            // Include any special characters you're using in this regular expression
            defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || [], 
            fontFace: true
        }),    
        require('autoprefixer')({
            grid: true
        }),
        require('postcss-reporter'),
    ]
}
