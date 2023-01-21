import 'package:flutter_test/flutter_test.dart';
import 'package:projeto_gestao_financeira_grupo_nove/src/shared/models/user_model.dart';
import 'package:faker/faker.dart';

void main() {
			group(
				'Testing UserModel',
				() {
					test(
						'fromMap when all data isnt null',
						() {
              var faker = Faker();
							final map = <String, dynamic>{
								'balance' : 25.76,
								'userModelID' : faker.guid.random.string(50),
								'userModelName' : faker.person.name(),
								'userModelDocID' : faker.guid.random.string(10),
								'categories' : List.generate(4, (index) => faker.food.toString()),
							};

							final user = UserModel.fromMap(map);

							expect(user.balance, map['balance']);
							expect(user.userModelID, map['userModelID']);
							expect(user.userModelName, map['userModelName']);
							expect(user.userModelDocID, map['userModelDocID']);
							expect(user.categories, map['categories']);
						},
					);
          test(
						'fromMap when all nullable data is null',
						() {
              var faker = Faker();
							final map = <String, dynamic>{
								'balance' : 25.76,
								'userModelID' : faker.guid.random.string(50),
								'userModelName' : faker.person.name(),
								'userModelDocID' : null,
								'categories' : List.generate(4, (index) => faker.food.toString()),
							};

							final user = UserModel.fromMap(map);

							expect(user.balance, map['balance']);
							expect(user.userModelID, map['userModelID']);
							expect(user.userModelName, map['userModelName']);
							expect(user.userModelDocID, '');
							expect(user.categories, map['categories']);
						},
					);
          test(
						'toMap when all data isnt null',
						() {
              var faker = Faker();
							final user = UserModel(
								balance : 25.76,
								userModelID : faker.guid.random.string(50),
								userModelName : faker.person.name(),
								userModelDocID : faker.guid.random.string(10),
								categories : List.generate(4, (index) => faker.food.toString()),
              );

							final map = user.toMap();

							expect(user.balance, map['balance']);
							expect(user.userModelID, map['userModelID']);
							expect(user.userModelName, map['userModelName']);
							expect(user.userModelDocID, map['userModelDocID']);
							expect(user.categories, map['categories']);
						},
					);
          test(
						'toMap when all nullable data is null',
						() {
              var faker = Faker();
							final user = UserModel(
								balance : 25.76,
								userModelID : faker.guid.random.string(50),
								userModelName : faker.person.name(),
								userModelDocID : '',
								categories : List.generate(4, (index) => faker.food.toString()),
              );

							final map = user.toMap();

							expect(user.balance, map['balance']);
							expect(user.userModelID, map['userModelID']);
							expect(user.userModelName, map['userModelName']);
							expect(user.userModelDocID, map['userModelDocID']);
							expect(user.categories, map['categories']);
						},
					);
				},
			);
		}