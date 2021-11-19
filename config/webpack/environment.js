const { environment, loaders } = require('@rails/webpacker');
environment.loaders.delete('nodeModules');

module.exports = environment
