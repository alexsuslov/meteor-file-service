/**
 * TODO support other encodings:
 * http://stackoverflow.com/questions/7329128/how-to-write-binary-data-to-a-file-using-node-js
 */
Meteor.methods({
  saveFile: function(blob, name, path, encoding) {
    var path = cleanPath(path)
      , fs = Npm.require('fs')
      , name = cleanName(name || 'file')
      , encoding = encoding || 'binary'
      , upPath = 'public'
      
    // Clean up the path. Remove any initial and final '/' -we prefix them-,
    // any sort of attempt to go to the parent directory '..' and any empty directories in
    // between '/////' - which may happen after removing '..'

    if (!fs.existsSync('public')){
      upPath = 'bundle/static';
    }    
    var chroot = Meteor.chroot || upPath;
    path = chroot + (path ? '/' + path + '/' : '/');
    mkdirPath = ''

    path.split("/").forEach(function(name){
      mkdirPath += name;
      if (!fs.existsSync(mkdirPath)){
        fs.mkdir(mkdirPath);
      }
      mkdirPath += '/';
    });

    // TODO Add file existance checks, etc...
    fs.writeFile(path + name, blob, encoding, function(err) {
      if (err) {
        throw (new Meteor.Error(500, 'Failed to save file.', err));
      } else {
        console.log('The file ' + name + ' (' + encoding + ') was saved to ' + path);
      }
    });

    function cleanPath(str) {
      if (str) {
        return str.replace(/^\/+/,'').replace(/\/+$/,'');
      }
    }
    function cleanName(str) {
      return str.replace(/\.\./g,'').replace(/\//g,'');
    }
  }
});