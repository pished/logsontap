const themeDir = __dirname + '/../../';

module.exports = {    
    plugins: [        
        require('postcss-import')({
            path: [themeDir]
            }), 
        require('tailwindcss')(themeDir + 'assets/css/tailwind.config.js'),
        // Configuration of purgecss for Tailwindcss
        // see https://tailwindcss.com/docs/controlling-file-size/#setting-up-purgecss  
        require('autoprefixer')({
            grid: true
        }),
        require('postcss-reporter'),
    ]
}
