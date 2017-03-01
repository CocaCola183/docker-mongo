const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const ObjectId = Schema.ObjectId;

// 配置schema
let user = new Schema({
  name: {type: String, default: 'kivi'},
  sex: {type: String, default: 'male'}
});

// 暴露model
mongoose.model('User', user);
const UserModel = mongoose.model('User');

// 这里的ip和端口号是集群启动的时候配置的
mongoose.connect('mongodb://192.168.99.100:30001,192.168.99.100:30002,192.168.99.100:30003,192.168.99.100:30004/test', {
	db: {
		readPreference: 'secondary', // primary, primaryPreferred, secondary, secondaryPreferred, nearest
		slaveOk: true
	}
}, (err) => {
	console.log(err);

	UserModel.create({name: 'kivi', sex: 'male'}, (err, results) => {
		if (err) {
			console.log('插入数据失败');
		}
		else {
			console.log(results);
			mongoose.disconnect((err) => {
				console.log(err);
			});
		}
	});
});