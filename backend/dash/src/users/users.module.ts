import { Module } from '@nestjs/common';
import { UserService } from './users.service';
import { UserController } from './users.controller';
import { FirebaseService } from 'src/firebase/firebase.service';
import { AppRepository } from 'src/app.repository';
import { User } from './entities/user.entity';
import { ResponseStrategy } from 'src/shared/strategies/response.strategy';
import { FirebaseModule } from 'src/firebase/firebase.module';

@Module({
  imports: [FirebaseModule],
  controllers: [UserController],
  providers: [
    UserService,
    ResponseStrategy,
    {
      provide: 'USER_COLLECTION',
      useValue: 'User',
    },
    {
      provide: 'USER_REPOSITORY',
      useFactory: (firebaseService: FirebaseService, collection: string) => {
        return new AppRepository<User>(firebaseService, collection);
      },
      inject: [FirebaseService, 'USER_COLLECTION'],
    },
  ],
  exports: [UserService],
})
export class UsersModule {}
