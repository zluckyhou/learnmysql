import pandas as pd

file_name = input('please input the file_name: ')

df = pd.read_csv('{}'.format(file_name),delimiter='\t',header=None,error_bad_lines=False)
df.columns = ['date','media','tag_name','tag_value','count']

tag_dict = df.groupby('tag_name')['count'].sum().to_dict()
pct = [format(df['count'].iloc[i]/tag_dict[df['tag_name'].iloc[i]],'.3f') for i in range(len(df))]
df['pct'] = pct
df.to_csv('{}.csv'.format(file_name),index=False)

print('Done!')


