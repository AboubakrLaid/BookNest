from decimal import Decimal, InvalidOperation
import csv
from django.core.management.base import BaseCommand, CommandError
from django.utils.dateparse import parse_datetime
from books.models import Book 

class Command(BaseCommand):
    help = 'Imports books from a specified CSV file'

    def add_arguments(self, parser):
        parser.add_argument('C:/Users/belmi/Desktop/books_api/api/books.csv', type=str, help='The CSV file path')

    def handle(self, *args, **options):
        csv_file_path = options['C:/Users/belmi/Desktop/books_api/api/books.csv']

        with open(csv_file_path, newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                # Handle conversion for Decimal fields
                try:
                    price = Decimal(row['price']) if row.get('price', '') else None
                    rating = Decimal(row['rating']) if row.get('rating', '') else None
                except InvalidOperation:
                    price = None
                    rating = None
                    self.stdout.write(self.style.ERROR(f"Invalid numeric value encountered; setting to None."))

                # Convert 'publish_date' from string to datetime
                publish_date = parse_datetime(row['publish_date']) if row.get('publish_date', '') else None

                # Convert string to int for 'pages' and 'ratings_number'
                pages = int(row['pages']) if row.get('pages', '').isdigit() else None
                ratings_number = int(row['ratings_number']) if row.get('ratings_number', '').isdigit() else None

                # Directly assign other fields, handling blank/null with empty string or explicit None
                book, created = Book.objects.update_or_create(
                    title=row['title'],
                    defaults={
                        'author': row.get('author', ''),
                        'rating': rating,
                        'description': row.get('description', ''),
                        'language': row.get('language', ''),
                        # 'categories': This needs special handling if you're linking existing categories
                        'pages': pages,
                        'publisher': row.get('publisher', ''),
                        'publish_date': publish_date,
                        'ratings_number': ratings_number,
                        'cover_image': row.get('cover_image', ''),
                        'price': price,
                    }
                )
                action = 'Created' if created else 'Updated'
                self.stdout.write(self.style.SUCCESS(f"{action} book: {book.title}"))
