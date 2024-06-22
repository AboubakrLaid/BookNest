import pandas as pd
from ast import literal_eval
import chardet

# Detect the encoding of the CSV file
with open('C:/Users/belmi/Downloads/categories.csv', 'rb') as f:
    result = chardet.detect(f.read())

# Read the CSV file into a DataFrame
books_df = pd.read_csv('C:/Users/belmi/Downloads/books_1.Best_Books_Ever.csv')  # Replace 'your_file.csv' with your actual file name
categories_df = pd.read_csv('C:/Users/belmi/Downloads/categories.csv',encoding=result['encoding'])

# Assuming the column containing categories is named 'Category', replace it with your actual column name
# categories_column = df['genres']

x = []
for i in categories_df['category']:
    x.append(i)
categories = x
print(len(x))

# Function to replace genre strings with IDs
books_categories= []
def replace_genre_with_id(genre_list):
    # Assuming genre_list is a list of genre names
    # print([categories.index(genre) for genre in genre_list if genre in categories])
    x = []
    for i in literal_eval(genre_list):
        x.append(i)
    y =  [categories.index(genre) for genre in x if genre in categories]
    y.sort()
    books_categories.append(y)
    
    return y

# Assuming the genre column is a string representation of a list, e.g., "['Fantasy', 'Adventure']"
# We need to convert it back to a list, replace, and then possibly back to a string if needed
# books_df['genres'] = literal_eval(books_df['genres']) # Convert string to list
books_df['genres'] = books_df['genres'].apply(lambda x: replace_genre_with_id(x))
print(books_categories)


    

books_df.to_csv('C:/Users/belmi/Downloads/modified_books.csv', index=False)
print('hi')

# # Get unique/distinct categories
# unique_categories = categories_column.unique()

# # Print the distinct categories
# from ast import literal_eval
# full_list = []
# for category in unique_categories:
#     full_list.extend(literal_eval(category))
    
# print(len(full_list))
# final = list(set(full_list))
# final.sort() 
# excluded = ['Gay','Israel','Lesbian','Lesbian Fiction','Queer', 'Queer Lit','LGBT','Young Adult', 'Young Adult Contemporary', 'Young Adult Fantasy', 'Young Adult Historical Fiction', 'Young Adult Paranormal', 'Young Adult Romance', 'Young Adult Science Fiction']
# result = [[f"'{item}'"] for item in final if item not in excluded]
# print(result)
# print(len(result))
    


