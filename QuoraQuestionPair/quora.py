
"""
Created on Thu Aug 24 13:27:48 2017
@author: kumar yashashwi
"""
import pandas as pd
import numpy as np
#from tqdm import tqdm 
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer
from random import shuffle
import nltk
words = set(nltk.corpus.words.words())
df=pd.read_csv('train.csv', sep=',', delimiter=None)
df1 =df.as_matrix()
label=df1[:,5].astype('int')
sentences1=df1[:,3]
sentences2=df1[:,4]
ps = PorterStemmer()
stop_words = set(stopwords.words('english'))
character = np.load('character.npy')
def sentence_clean(sentence):
    filtered_sentence=[]
    word_tokens = str(sentence).lower().split()
    word_tokens[-1]=word_tokens[-1].replace('?',' ')
    for w in word_tokens:
        for p in range(0,len(character)):
            w = w.replace(character[p],'') 
        w = ' '.join([i for i in w if not i.isdigit()])
        if w not in stop_words:
#            w=ps.stem(w)
            filtered_sentence.append(w)
    return filtered_sentence

#print(sentence_clean(str(sentences1[14])))

def Vocabulary(sentences):
    Vocabulary=[]
    for sentence in (sentences):
        sen=sentence_clean(sentence)        
        for word in sen:
            if len(word)>=3:
                if word not in Vocabulary:
                    Vocabulary.append(word)
    return Vocabulary


#all_sentences=np.hstack((sentences1,sentences2))
#Vocab=Vocabulary(all_sentences)
#np.save('Vocabulary.npy',Vocab)
#Vocab=np.load('Vocabulary.npy')
#shuffle(Vocab)



def vec(Vocab,sentence):
#    train_samples=np.zeros([len(all_sentences),len(Vocab)])
    vector=np.zeros(len(Vocab))
    word_temp=sentence_clean(sentence)
    for q in range(0,len(word_temp)):
        for w in range(0,len(Vocab)):
           if (word_temp[q]==Vocab[w]):
              vector[w]=1 
    return [vector]
dist=np.zeros(len(sentences1))
angle=np.zeros(len(sentences1))

for j in range(0,len(sentences1)):
    both_sentences=np.hstack((sentences1[j],sentences2[j]))
    Vocab=Vocabulary(both_sentences)
    vec1=vec(Vocab,sentences1[j])
    vec2=vec(Vocab,sentences2[j])
    dist[j] = np.linalg.norm(np.array(vec1)-np.array(vec2))
    angle[j] = np.dot(vec1,np.transpose(vec2))/float((np.linalg.norm(vec1)*np.linalg.norm(vec2)))


from sklearn.neural_network import MLPClassifier
nans=np.argwhere(np.isnan(angle))
dist_n=np.delete(dist,nans)
angle_n=np.delete(angle,nans)
label=np.delete(label,nans)
x_train=np.transpose(np.vstack((dist_n[0:300000],angle_n[0:300000])))
y_train=label[0:300000]
x_valid=np.transpose(np.vstack((dist_n[300000:],angle_n[300000:])))
y_valid=label[300000:]

from sklearn import tree
clf = MLPClassifier()
clf.fit(x_train, y_train)
y_pred=clf.predict(x_valid)
acc=(len(y_valid)-np.count_nonzero(y_valid-y_pred))/len(y_valid) 
print(acc)

