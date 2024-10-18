import { Inject, Injectable } from '@nestjs/common';
import { CreateCharacterDto } from './dto/create-character.dto';
import { UpdateCharacterDto } from './dto/update-character.dto';
import { Character } from './entities/character.entity';
import { ResponseStrategy } from '../shared/strategies/response.strategy';
import { AppRepository } from 'src/app.repository';

@Injectable()
export class CharacterService {
  constructor(
    @Inject('CHARACTER_REPOSITORY')
    private characterRepository: AppRepository<Character>,
    private responseStrategy: ResponseStrategy,
  ) {}

  async create(createCharacterDto: CreateCharacterDto) {
    try {
      const character: Character = {
        accessory: 0,
        hair: 0,
        pants: 0,
        shirts: 0,
        shoes: 0,
      };
      const id = await this.characterRepository.createById(
        character,
        createCharacterDto.id,
      );
      return this.responseStrategy.success('Character created successfully', {
        id,
        ...character,
      });
    } catch (error) {
      return this.responseStrategy.error('Failed to create character', error);
    }
  }

  async findAll() {
    try {
      const characters = await this.characterRepository.findAll();
      return characters.length === 0
        ? this.responseStrategy.noContent('No characters found')
        : this.responseStrategy.success(
            'Characters retrieved successfully',
            characters,
          );
    } catch (error) {
      return this.responseStrategy.error(
        'Failed to retrieve characters',
        error,
      );
    }
  }

  async findOne(id: string) {
    try {
      const character = await this.characterRepository.findOne(id);
      return character
        ? this.responseStrategy.success(
            'Character retrieved successfully',
            character,
          )
        : this.responseStrategy.notFound('Character not found');
    } catch (error) {
      return this.responseStrategy.error('Failed to retrieve character', error);
    }
  }

  async update(id: string, updateCharacterDto: UpdateCharacterDto) {
    try {
      const existingCharacter = await this.characterRepository.findOne(id);
      if (!existingCharacter) {
        return this.responseStrategy.notFound('Character not found');
      }
      const updatedCharacter: Partial<Character> = {
        ...updateCharacterDto,
      };
      await this.characterRepository.update(id, updatedCharacter);
      return this.responseStrategy.success('Character updated successfully', {
        id,
        ...existingCharacter,
        ...updatedCharacter,
      });
    } catch (error) {
      return this.responseStrategy.error('Failed to update character', error);
    }
  }

  async remove(id: string) {
    try {
      const existingCharacter = await this.characterRepository.findOne(id);
      if (!existingCharacter) {
        return this.responseStrategy.notFound('Character not found');
      }
      await this.characterRepository.remove(id);
      return this.responseStrategy.success('Character deleted successfully');
    } catch (error) {
      return this.responseStrategy.error('Failed to delete character', error);
    }
  }
}
