import { Module } from '@nestjs/common';
import { CharacterService } from './characters.service';
import { CharacterController } from './characters.controller';
import { FirebaseService } from 'src/firebase/firebase.service';
import { AppRepository } from 'src/app.repository';
import { Character } from './entities/character.entity';
import { ResponseStrategy } from 'src/shared/strategies/response.strategy';
import { FirebaseModule } from 'src/firebase/firebase.module';

@Module({
  imports: [FirebaseModule],
  controllers: [CharacterController],
  providers: [
    CharacterService,
    ResponseStrategy,
    {
      provide: 'CHARACTER_COLLECTION',
      useValue: 'Character',
    },
    {
      provide: 'CHARACTER_REPOSITORY',
      useFactory: (firebaseService: FirebaseService, collection: string) => {
        return new AppRepository<Character>(firebaseService, collection);
      },
      inject: [FirebaseService, 'CHARACTER_COLLECTION'],
    },
  ],
  exports: [CharacterService],
})
export class CharactersModule {}
