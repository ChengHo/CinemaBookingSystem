module.exports = {
    devServer: {
        port: 8888
    },
    publicPath:process.env.NODE_ENV === 'production' ? '/panda-ui' : '/'
}
