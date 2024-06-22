from ast import literal_eval
from django.core.management.base import BaseCommand, CommandError
from books.models import Book,Category
# from django.db import transaction

class Command(BaseCommand):
    help = 'update books categories'

    def add_arguments(self, parser):
        parser.add_argument('C:/Users/belmi/Desktop/books_api/api/output.txt', type=str, help='The CSV file path')

    def handle(self, *args, **options):
        csv_file_path = options['C:/Users/belmi/Desktop/books_api/api/output.txt']

        with open(csv_file_path, newline='', encoding='utf-8') as file:
        # with transaction.atomic():

            books_categories_id = literal_eval(file.read())
            i =1
            
            for ids in books_categories_id[:815]:
                categories = Category.objects.filter(id__in = ids)
                book =  Book.objects.get(id = i)
                try:
                    book = Book.objects.get(id=i)
                    # book.categories.remove(Category.objects.all())
                    book.categories.clear()
                    book.categories.set(categories)
                except Book.DoesNotExist:
                     print('not exist')
                i += 1
            # book = Book.objects.get(id = 1)
            # for i in book.categories.all():
            #     print(i.id)
            # print(books_categories_id[0])
            self.stdout.write(self.style.SUCCESS("good"))
