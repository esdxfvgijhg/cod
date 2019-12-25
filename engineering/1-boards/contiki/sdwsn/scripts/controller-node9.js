const Graph = require('node-dijkstra')
const route = new Graph()
var coap = require('coap');
var nodenumber = 2;
var req = {};
var program = require('commander');
var hostprefix = "fd00::200:0:0:";
var nexthopprefix = "fe80::200:0:0:";
var noderesp = '';
var caminho = new Array();
const allresponsestimeout = 10000;

program
	.option('-n, --nodes <option>', 'set the number of nodes', parseInt);

program.parse(process.argv);

if (program.nodes && (program.nodes < 1 || program.nodes > 128)) {
	console.log('Invalid nodes number, valid range [1..128]')
	process.exit(-1)
}

while( nodenumber <= program.nodes + 1) {
	req = coap.request({host: hostprefix + nodenumber.toString(16) , pathname: '/sdwsn/etx', observe: false });
	req.setOption('Max-Age', 65);
	req.on('response', function(res) {
	    noderesp = JSON.parse(res.read());
		console.log(noderesp.node,noderesp.nbr);
		route.addNode(noderesp.node, noderesp.nbr);
	})
	nodenumber = nodenumber + 1;
	req.end();
} 
function treeCalc() {
	console.log("Melhores caminhos para a raiz:"); 
	for ( i = 2; i <= program.nodes ; i++ ) {
	    caminho[i] = route.path("n" + i, "n1");
		console.log(caminho[i]);  // [ 'n5', 'n6', 'n1' ]
		var caminhosize = 0;
		var ipv6srctemp = 0;
		for (var prop in caminho[i]) caminhosize ++;   // count number of nodes in path
		for (var nos = 0; nos < caminhosize; nos++) {
		    if (nos < caminhosize - 1){ 
		        var indextemp = nos + 1;
		    	var installnodetemp = hostprefix + parseInt(caminho[i][nos].slice(1)).toString(16);
		    	var nxhoptemp = nexthopprefix + parseInt(caminho[i][nos+1].slice(1)).toString(16);
		    	if (nos > 0) ipv6srctemp = hostprefix + parseInt(caminho[i][nos-1].slice(1)).toString(16);
		    	else ipv6srctemp = installnodetemp ;
		    	console.log(installnodetemp,ipv6srctemp,0,nxhoptemp);
		    	installflow(installnodetemp,indextemp,ipv6srctemp,0,nxhoptemp);
		    }
		}
	}
}
function installflow(installnode,index,ipv6src,ipv6dst,nxhop) {
  var reqput = coap.request({host: installnode , pathname: '/sdwsn/flow-mod', method: 'PUT' });
  //console.log("installnode=",installnode);
  reqput.write('insert?index=' + index + '&ipv6src="' + ipv6src + '"&ipv6dst="' + ipv6dst + '"&nhmacaddr="' +  nxhop +'"&txpwr="3"');

  reqput.on('response', function(res) {
    res.pipe(process.stdout);
  })

  reqput.end();
}
setTimeout(treeCalc, allresponsestimeout);

 


